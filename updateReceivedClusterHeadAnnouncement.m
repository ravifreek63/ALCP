function receivedClusterHeadAnnouncement = updateReceivedClusterHeadAnnouncement (Sn_length, Y, oneHopNeighborInfo)
receivedClusterHeadAnnouncement = zeros (Sn_length, Sn_length);
            for i = 1 : Sn_length
                if (Y(i,i) ~= 1)
                    continue
                end
                for j = 1 : Sn_length 
                    if (oneHopNeighborInfo (i,j) == 1)
                        receivedClusterHeadAnnouncement (j, i) = 1;
                    end
                end
            end
end