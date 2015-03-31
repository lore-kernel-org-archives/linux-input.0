From: Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 2/2] input: tsc2007: Don't require an interrupt to load
Date: Tue, 31 Mar 2015 16:55:29 -0500 (CDT)
Message-ID: <783099319.65159.1427838929389.JavaMail.zimbra@xes-inc.com>
References: <1959876509.19488.1427814135809.JavaMail.zimbra@xes-inc.com> <2054629675.19924.1427814365859.JavaMail.zimbra@xes-inc.com> <20150331213518.GC29015@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:57873 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbbCaV4g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 17:56:36 -0400
In-Reply-To: <20150331213518.GC29015@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>, Philip Rakity <prakity@marvell.com>, linux-input@vger.kernel.org

----- Original Message -----
> From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
> Sent: Tuesday, March 31, 2015 4:35:18 PM
> 
> Hi Aaron,
> 
> On Tue, Mar 31, 2015 at 10:06:05AM -0500, Aaron Sierra wrote:
> > When an IRQ isn't available, poll the device based on poll_period.
> 
> What is the point in using such mode? Why would not IRQ be available?
> If this is for device bringup I'd say just carry this locally.

Dmitry,
I am using this touchscreen in a system where the PENIRQ# output is
tied to a GPIO. I was originally taking advantage of the poll_delay
value from the platform_data structure, but that has since been
removed.

I am fine maintaining this locally. Thanks.

-Aaron S.
