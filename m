From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V3 1/3] ACPI video hotkey: add new input key code for ACPI video hotkey events
Date: Fri, 24 Aug 2007 00:10:50 -0400
Message-ID: <200708240010.51111.lenb@kernel.org>
References: <1187605427.2920.140.camel@acpi-hp.sh.intel.com> <200708231532.42908.lenb@kernel.org> <d120d5000708231310oeb4e365k3108ed55bc230bd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000708231310oeb4e365k3108ed55bc230bd1@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, mjg59@srcf.ucam.org, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

On Thursday 23 August 2007 16:10, Dmitry Torokhov wrote:
> On 8/23/07, Len Brown <lenb@kernel.org> wrote:
> > Thanks for the refreshed patch series, Rui.
> > I've added it to acpi-test.
> >
> > Still waiting on an ACK from Dmitry on the input.h definitions.
> 
> Sorry, I am still trying to recover from a hard drive failure...
> 
> The keycodes conflict with a pending patch adding KEY_BRL_DOT9 and
> KEY_BRL_DOT10 and so have to be moved somewhere else.
> 

Okay, I moved them to lower numbers
(no clue why the 1st part of the list is decimal and the
 later part is hex).

and I omitted KEY_DISPLAY_CYCLE in favor of re-using
the existing KEY_SWITCHVIDEOMODE.

thanks,
-Len
---
commit a7ecd1ea913346a72f41a002c365882dc05c9bd5
Author: Yu Luming <luming.yu@intel.com>
Date:   Thu Aug 23 23:05:55 2007 -0400

    ACPI: video: Add keycode for ACPI video driver hotkey events.
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/include/linux/input.h b/include/linux/input.h
index e02c6a6..cf2b561 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -363,6 +363,12 @@ struct input_absinfo {
 
 #define KEY_UNKNOWN		240
 
+#define KEY_VIDEO_NEXT		241	/* drive next video source */
+#define KEY_VIDEO_PREV		242	/* drive previous video source */
+#define KEY_BRIGHTNESS_CYCLE	243	/* brightness up, after max is min */
+#define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
+#define KEY_DISPLAY_OFF		245	/* display device to off state */
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
