From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Mon, 30 Nov 2015 15:38:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1511301536450.1938-100000@iolanthe.rowland.org>
References: <20151130194017.GA14889@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40896 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751691AbbK3UiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 15:38:21 -0500
In-Reply-To: <20151130194017.GA14889@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vladis Dronov <vdronov@redhat.com>, linux-input@vger.kernel.org

On Mon, 30 Nov 2015, Dmitry Torokhov wrote:

> How about we do something like below?

It looks okay to me.  If you want to propose it on the linux-usb 
mailing list, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

