From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] HID: Documentation for hidraw
Date: Fri, 18 Jun 2010 08:45:07 -0700
Message-ID: <20100618084507.3dcba19a.rdunlap@xenotime.net>
References: <1276832283-12084-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.115.56]:56906 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932443Ab0FRPpK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 11:45:10 -0400
Received: from chimera.site ([98.108.160.27]) by xenotime.net for <linux-input@vger.kernel.org>; Fri, 18 Jun 2010 08:45:07 -0700
In-Reply-To: <1276832283-12084-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, 17 Jun 2010 23:38:03 -0400 Alan Ott wrote:

> Documenation for the hidraw driver.
> 
> Signed-off-by: Alan Ott <alan@signal11.us>
> ---
> 
>  Documentation/hidraw.txt |  283 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 283 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hidraw.txt

In the new sub-directory, please split the example/test program into a separate
source file and add a Makefile so that it will build.

There are similar Makefiles in many other Documentation/ sub-directories.

thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
