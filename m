From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 0/1] HID: Report Descriptor in Sysfs
Date: Thu, 17 Feb 2011 13:26:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102171323590.2160@pobox.suse.cz>
References: <20110123225935.GB12488@kroah.com> <1295841018-8561-1-git-send-email-alan@signal11.us> <4D5B4E5D.5060101@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4D5B4E5D.5060101@signal11.us>
Sender: linux-doc-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, greg@kroah.com, stern@rowland.harvard.edu, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

On Tue, 15 Feb 2011, Alan Ott wrote:

> > Using the /sys/class links, for hidraw devices, this puts a new file,
> > report_descriptor in the directory:
> > 	/sys/class/hidraw/hidraw0/device/
> 
> I Didn't get any responses on the fixed-up patch. Does anyone have any 
> issue with this?

I have applied the patch, thanks Alan.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
