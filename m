From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] Don't Send Feature Reports on Interrupt Endpoint
Date: Wed, 15 Sep 2010 12:10:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009151203030.1796-100000@iolanthe.rowland.org>
References: <1284561909-14350-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50264 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752085Ab0IOQKO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 12:10:14 -0400
In-Reply-To: <1284561909-14350-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 15 Sep 2010, Alan Ott wrote:

> Feature reports should only be sent on the control endpoint.

Where is this requirement?  Section 5.6 of the HID spec says: 

	Note  Only Input reports are sent via the Interrupt In pipe. 
	Feature and Output reports must be initiated by the host via
	the Control pipe or an optional Interrupt Out pipe.

So if there is an Interrupt-OUT endpoint, it should be valid to use it 
for a Feature report.

Alan Stern

