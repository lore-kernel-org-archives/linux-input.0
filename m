From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v2 0/2] HID: hidraw documentation
Date: Fri, 18 Jun 2010 20:14:45 -0700
Message-ID: <20100618201445.28c58573.rdunlap@xenotime.net>
References: <1276832283-12084-1-git-send-email-alan@signal11.us>
	<1276913623-6126-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.115.56]:50405 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587Ab0FSDOv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 23:14:51 -0400
Received: from chimera.site ([98.108.160.27]) by xenotime.net for <linux-input@vger.kernel.org>; Fri, 18 Jun 2010 20:14:46 -0700
In-Reply-To: <1276913623-6126-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Fri, 18 Jun 2010 22:13:41 -0400 Alan Ott wrote:

> These patches add the hidraw.txt file to a new Documentation/hid/ directory.
> 
> The example program has been moved out of the document and fixed up for style
> (it's now checkpatch.pl clean), and a Makefile has been created for it.
> 
> I integrated the comments provided.
> 
> hiddev.txt has been moved from Documentation/usb/ to Documentation/hid/
> 
> 
> Alan Ott (2):
>   HID: Documentation for hidraw
>   HID: Move hiddev.txt to the new Documentation/HID directory

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Jiri, can you merge these patches, please?

>  Documentation/hid/Makefile            |    8 ++
>  Documentation/hid/hid-example.c       |  167 +++++++++++++++++++++++++++++++++
>  Documentation/{usb => hid}/hiddev.txt |    0
>  Documentation/hid/hidraw.txt          |  119 +++++++++++++++++++++++
>  4 files changed, 294 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hid/Makefile
>  create mode 100644 Documentation/hid/hid-example.c
>  rename Documentation/{usb => hid}/hiddev.txt (100%)
>  create mode 100644 Documentation/hid/hidraw.txt

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
