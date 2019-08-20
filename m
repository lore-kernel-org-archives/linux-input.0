From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 1/2] fs: ntfs: drop unneeded likely() call around IS_ERR()
Date: Tue, 20 Aug 2019 12:56:11 +0200
Message-ID: <1566298572-12409-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: pali.rohar@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

IS_ERR() already calls unlikely(), so this extra likely() call
around the !IS_ERR() is not needed.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 fs/ntfs/mft.c     | 8 ++++----
 fs/ntfs/namei.c   | 2 +-
 fs/ntfs/runlist.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 20c841a..06f706b 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -71,7 +71,7 @@ static inline MFT_RECORD *map_mft_record_page(ntfs_inode *ni)
 	}
 	/* Read, map, and pin the page. */
 	page = ntfs_map_page(mft_vi->i_mapping, index);
-	if (likely(!IS_ERR(page))) {
+	if (!IS_ERR(page)) {
 		/* Catch multi sector transfer fixup errors. */
 		if (likely(ntfs_is_mft_recordp((le32*)(page_address(page) +
 				ofs)))) {
@@ -154,7 +154,7 @@ MFT_RECORD *map_mft_record(ntfs_inode *ni)
 	mutex_lock(&ni->mrec_lock);
 
 	m = map_mft_record_page(ni);
-	if (likely(!IS_ERR(m)))
+	if (!IS_ERR(m))
 		return m;
 
 	mutex_unlock(&ni->mrec_lock);
@@ -271,7 +271,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 		m = map_mft_record(ni);
 		/* map_mft_record() has incremented this on success. */
 		atomic_dec(&ni->count);
-		if (likely(!IS_ERR(m))) {
+		if (!IS_ERR(m)) {
 			/* Verify the sequence number. */
 			if (likely(le16_to_cpu(m->sequence_number) == seq_no)) {
 				ntfs_debug("Done 1.");
@@ -1776,7 +1776,7 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	do {
 		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE,
 				true);
-		if (likely(!IS_ERR(rl2)))
+		if (!IS_ERR(rl2))
 			break;
 		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
 			ntfs_error(vol->sb, "Failed to allocate the minimal "
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 2d3cc9e..4e6a44b 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -115,7 +115,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		dent_ino = MREF(mref);
 		ntfs_debug("Found inode 0x%lx. Calling ntfs_iget.", dent_ino);
 		dent_inode = ntfs_iget(vol->sb, dent_ino);
-		if (likely(!IS_ERR(dent_inode))) {
+		if (!IS_ERR(dent_inode)) {
 			/* Consistency check. */
 			if (is_bad_inode(dent_inode) || MSEQNO(mref) ==
 					NTFS_I(dent_inode)->seq_no ||
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 508744a..97932fb 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -951,7 +951,7 @@ runlist_element *ntfs_mapping_pairs_decompress(const ntfs_volume *vol,
 	}
 	/* Now combine the new and old runlists checking for overlaps. */
 	old_rl = ntfs_runlists_merge(old_rl, rl);
-	if (likely(!IS_ERR(old_rl)))
+	if (!IS_ERR(old_rl))
 		return old_rl;
 	ntfs_free(rl);
 	ntfs_error(vol->sb, "Failed to merge runlists.");
-- 
1.9.1
