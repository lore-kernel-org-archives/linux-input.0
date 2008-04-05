From: Oliver Neukum <oliver@neukum.org>
Subject: Re: suspend
Date: Sat, 5 Apr 2008 10:00:25 +0200
Message-ID: <200804051000.26661.oliver@neukum.org>
References: <200804032242.36493.oliver@neukum.org> <200804041336.32457.oliver@neukum.org> <e79639220804041540u3b0278cchff1d36b4cba5fc05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:45443 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbYDEIG5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Apr 2008 04:06:57 -0400
In-Reply-To: <e79639220804041540u3b0278cchff1d36b4cba5fc05@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Schweizer <genstef@gentoo.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Samstag, 5. April 2008 00:40:35 schrieb Stefan Schweizer:
> On Fri, Apr 4, 2008 at 1:36 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Freitag, 4. April 2008 11:20:51 schrieb Stefan Schweizer:
> >
> > > Yeah, I tested it with the combined patch. How can I test if
> >  > autosuspend works? Seems to work fine so far but does not write in my
> >  > logfile. No problems found when testing.
> >
> >  Please compile your kernel with CONFIG_PM_DEBUG and follow the
> >  instructions in Documentation/usb. You should see something in the log.
> 
> there is still no information in dmesg when I use the device. Do I
> need more debugging maybe?

Ok, please locate the directory for your touchpad in sysfs and post all
files in the power subdirectory.

	Regards
		Oliver
