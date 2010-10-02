From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] HID: hidraw, fix a NULL pointer dereference in hidraw_ioctl
Date: Sat,  2 Oct 2010 13:25:24 +0200
Message-ID: <1286018724-7484-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:45474 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952Ab0JBLZt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 07:25:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org

BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
IP: [<ffffffffa02c66b4>] hidraw_ioctl+0xfc/0x32c [hid]
[...]

This is reproducible by disconnecting the device while userspace does ioctl in
a loop and doesn't check return values in order to exit the loop, like in the
following test program:

int main(int argc, char *argv[])
{
	int fd = -1;
	unsigned char name[256];
	int ret;

	if (argc != 2) {
		fprintf(stderr, "usage: %s </dev/hidrawX>\n",
				argv[0]);
		exit(1);
	}

	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		perror("hidraw open");
		exit(1);
	}

	while (1) {
		ret = ioctl(fd, HIDIOCGRAWNAME(256), name);
		printf("ret: %d name: %s\n", ret, name);
	}

	close(fd);
	exit(0);
}

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
Should this be applied to older stable kernels too?

Alan, Jiri,

there is a similar problem when _writing_ to the device, but Alan's
changes in that area are shuffling the code a bit, should I send a patch
[to hidraw_send_report()] on top of Alan's work for that, or a fix for
current mainline [in hidraw_write()] on which Alan should rebase his
work would be better?

The same pattern of unchecked hidraw_table[minor] is also present in
hidraw_get_report but this function is called only after the NULL check
in hidraw_ioctl _for_now_, so that is currently safe.

Thanks,
   Antonio Ospite
   http://ao2.it

 drivers/hid/hidraw.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 47d70c5..9eaf6ae 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -244,6 +244,10 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 
 	mutex_lock(&minors_lock);
 	dev = hidraw_table[minor];
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	switch (cmd) {
 		case HIDIOCGRDESCSIZE:
@@ -317,6 +321,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 
 		ret = -ENOTTY;
 	}
+out:
 	mutex_unlock(&minors_lock);
 	return ret;
 }
-- 
1.7.1

