From: Jim Gettys <jg@laptop.org>
Subject: Re: How do I find updates to the USB HID usage tables?
Date: Thu, 11 Dec 2008 16:48:35 -0500
Message-ID: <1229032115.14656.380.camel@jg-vaio>
References: <1229008606.14656.347.camel@jg-vaio>
	 <20081211153529.GB13887@kroah.com> <1229011317.14656.355.camel@jg-vaio>
	 <alpine.LRH.1.10.0812112201450.11630@twin.jikos.cz>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:48549
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757320AbYLKVsi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2008 16:48:38 -0500
In-Reply-To: <alpine.LRH.1.10.0812112201450.11630@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Greg KH <greg@kroah.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

The USB web site on

http://www.usb.org/developers/hidpage/question/

refers to a process for how new values are assigned (answer to question
2.b); it talks about some "HID web page" where some such additions may
be put until some annual update of the document: of course, version 1.12
is 2004, so who knows what may be lurking on some mythical USB page, if
anything...  
                  - Jim

On Thu, 2008-12-11 at 22:03 +0100, Jiri Kosina wrote:
> On Thu, 11 Dec 2008, Jim Gettys wrote:
> 
> > Whether they are being used properly, is what I'd like to ensure; I have 
> > a comment or two in the report data structure source I have that would 
> > give me insight as to whether they are using them correctly.  If not, I 
> > want to complain at them...
> 
> Well, if they are reserved in 1.12 HUT, I doubt there is any usage that 
> can be considered correct.
> 
-- 
Jim Gettys <jg@laptop.org>
One Laptop Per Child

