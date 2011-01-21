From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/1] HID: Report Descriptor in Sysfs
Date: Fri, 21 Jan 2011 16:09:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101211607290.5725@pobox.suse.cz>
References: <1295590785-7101-1-git-send-email-alan@signal11.us> <alpine.LNX.2.00.1101211054210.5725@pobox.suse.cz> <4D399DAB.3080808@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D399DAB.3080808@signal11.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 21 Jan 2011, Alan Ott wrote:

> Maybe it is. To be honest I didn't check debugfs. I have two concerns about
> it:
> 1. Is it wise for userspace programs to rely on:

Ah, I didn't realize that you want it to be used by some acutal userspace 
applications. Out of curiosity -- what is the usage pattern you are 
targetting?

The idea behind debugfs-provided userspace descriptor is that driver 
developer is easily able to inspect the descriptor, and write a kernel 
driver that fixes it up in case it is bogus.
There were also efforts to make the report descriptor replaceable in a 
request_firmware() way, but that never converged to state in which it 
could be applied IIRC.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
