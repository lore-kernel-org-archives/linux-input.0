From: Guillem Jover <guillem.jover@nokia.com>
Subject: [PATCH] ACPI: Always report a sync event after a lid state change
Date: Fri, 24 Oct 2008 00:28:33 +0300
Message-ID: <20081023212833.GA1923@ziggurat.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30597 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYJWV26 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2008 17:28:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

Currently not always an EV_SYN event is reported to userland
after the EV_SW SW_LID event has been sent. This is easy to verify
by using =E2=80=9Cinput-events=E2=80=9D from input-utils and just closi=
ng and opening
the lid.

Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
---
 drivers/acpi/button.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1dfec41..59352d9 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -262,6 +262,7 @@ static int acpi_lid_send_state(struct acpi_button *=
button)
 		return -ENODEV;
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
+	input_sync(button->input);
 	return 0;
 }
=20
@@ -285,8 +286,8 @@ static void acpi_button_notify(acpi_handle handle, =
u32 event, void *data)
 			input_report_key(input, keycode, 1);
 			input_sync(input);
 			input_report_key(input, keycode, 0);
+			input_sync(input);
 		}
-		input_sync(input);
=20
 		acpi_bus_generate_proc_event(button->device, event,
 					++button->pushed);
--=20
1.6.0.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
