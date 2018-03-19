From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] HID: alps: Fix some bugs and improve code around  't4_read_write_register()'
Date: Mon, 19 Mar 2018 21:53:25 +0100
Message-ID: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: masaki.ota@jp.alps.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

All is said in the subject and below.

These patches are untested. Especially, patch 1 slightly changes the behavior
of 't4_read_write_register()'.
This looks logical to me, but please, review it carefully.

Christophe JAILLET (4):
  HID: alps: Report an error if we receive invalid data in
    't4_read_write_register()'
  HID: alps: Save a memory allocation in 't4_read_write_register()' when
    writing data
  HID: alps: Check errors returned by 't4_read_write_register()'
  HID: alps: Fix some style in 't4_read_write_register()'

 drivers/hid/hid-alps.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.14.1
