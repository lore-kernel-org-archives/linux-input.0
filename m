From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: How do I find updates to the USB HID usage tables?
Date: Thu, 11 Dec 2008 22:03:45 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0812112201450.11630@twin.jikos.cz>
References: <1229008606.14656.347.camel@jg-vaio>  <20081211153529.GB13887@kroah.com> <1229011317.14656.355.camel@jg-vaio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:47263 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbYLKVDz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2008 16:03:55 -0500
In-Reply-To: <1229011317.14656.355.camel@jg-vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jim Gettys <jg@laptop.org>
Cc: Greg KH <greg@kroah.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 11 Dec 2008, Jim Gettys wrote:

> Whether they are being used properly, is what I'd like to ensure; I have 
> a comment or two in the report data structure source I have that would 
> give me insight as to whether they are using them correctly.  If not, I 
> want to complain at them...

Well, if they are reserved in 1.12 HUT, I doubt there is any usage that 
can be considered correct.

-- 
Jiri Kosina
SUSE Labs

