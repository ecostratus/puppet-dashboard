class RemoveDuplicateClassAndGroupMemberships < ActiveRecord::Migration[4.2]
  def self.up
    count = NodeClassMembership.where('id NOT IN (SELECT min(id) FROM node_class_memberships GROUP BY node_id, node_class_id)').destroy_all.size
    if count > 0
      say "WARNING: Deleted #{count} duplicate classes on nodes.  These records are completely redundant (A node _directly_ belonging to a group more than once)."
    end

    count = NodeGroupMembership.where('id NOT IN (SELECT min(id) FROM node_group_memberships GROUP BY node_id, node_group_id)').destroy_all.size
    if count > 0
      say "WARNING: Deleted #{count} duplicate groups on nodes.  These records are completely redundant (A node _directly_ belonging to a group more than once)."
    end

    count = NodeGroupClassMembership.where('id NOT IN (SELECT min(id) FROM node_group_class_memberships GROUP BY node_group_id, node_class_id)').destroy_all.size
    if count > 0
      say "WARNING: Deleted #{count} duplicate classes on groups.  These records are completely redundant (A group _directly_ belonging to a class more than once)."
    end

    count = NodeGroupEdge.where('id NOT IN (SELECT min(id) FROM node_group_edges GROUP BY to_id, from_id)').destroy_all.size
    if count > 0
      say "WARNING: Deleted #{count} duplicate group memberships on groups.  These records are completely redundant (A group _directly_ belonging to a group more than once)."
    end
  end

  def self.down
  end
end
