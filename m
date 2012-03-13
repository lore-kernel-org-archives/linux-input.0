From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: Fix autosuspend on bcm5974
Date: Tue, 13 Mar 2012 17:32:18 +0100
Message-ID: <20120313163218.GA2680@polaris.bitmath.org>
References: <1331596278-2495-1-git-send-email-mjg@redhat.com>
 <20120313143958.GA2754@polaris.bitmath.org>
 <20120313144941.GA13637@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:56067 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab2CMQa3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 12:30:29 -0400
Content-Disposition: inline
In-Reply-To: <20120313144941.GA13637@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrik Rydberg <rydberg@bitmath.se>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

> What do you mean by "normal tap"? By "not enabled by default" I mean the 
> kernel doesn't enable autosuspend on input devices. Userspace would have 
> to do that.

A normal tap is a short distinct touch, normally in the 100
millisecond range or so. I am not sure what is unclear about it. :-)

Have you not experienced this problem? Simply wait for some seconds
for the device to suspend, then perform a tap while monitoring the
device output.

Henrik
