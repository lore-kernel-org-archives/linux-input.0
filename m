From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v5 0/2] Documentation and Sample for hidraw
Date: Mon, 21 Mar 2011 13:17:32 -0700
Message-ID: <20110321131732.8e8906a8.rdunlap@xenotime.net>
References: <1297829209-10511-1-git-send-email-alan@signal11.us>
	<1300580985-10726-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1300580985-10726-1-git-send-email-alan@signal11.us>
Sender: linux-doc-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jonathan Corbet <corbet@lwn.net>, Antonio Ospite <ospite@studenti.unina.it>, Jiri Kosina <jkosina@suse.cz>, Jason Wessel <jason.wessel@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, Stefani Seibold <stefani@seibold.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 19 Mar 2011 20:29:43 -0400 Alan Ott wrote:

> Sorry I've been slack in getting v5 of this patch out. Because
> it's been so long, I'll recap what happened last time:
> 
>  * Jon Corbet suggested that the example programs be moved into samples/ .
>  * Randy Dunlap indicated his acked-by when this was done.
> 
> These patches add hidraw.txt to a new Documentation/hid/ directory.
> 
> It creates an example program which is now in samples/ with a Kconfig item.
> 
> The existing hiddev.txt has been moved from Documentation/usb/ to
> Documentation/hid/

Jiri,

I suppose that you will merge these patches?
or did you want me to do it?


> This is based on .38+
> 
> Alan Ott (2):
>   HID: Documentation for hidraw
>   HID: Move hiddev.txt to the new Documentation/HID directory
> 
>  Documentation/{usb => hid}/hiddev.txt |    0
>  Documentation/hid/hidraw.txt          |  119 +++++++++++++++++++++++
>  samples/Kconfig                       |    6 +
>  samples/Makefile                      |    2 +-
>  samples/hidraw/Makefile               |    8 ++
>  samples/hidraw/hid-example.c          |  167 +++++++++++++++++++++++++++++++++
>  6 files changed, 301 insertions(+), 1 deletions(-)
>  rename Documentation/{usb => hid}/hiddev.txt (100%)
>  create mode 100644 Documentation/hid/hidraw.txt
>  create mode 100644 samples/hidraw/Makefile
>  create mode 100644 samples/hidraw/hid-example.c
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
