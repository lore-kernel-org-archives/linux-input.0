From: David Hagood <david.hagood@aeroflex.com>
Subject: Re: [Bugme-new] [Bug 12447] New: usbtouchscreen submits URB too
	quickly if built in to kernel
Date: Wed, 14 Jan 2009 17:08:28 -0600
Message-ID: <1231974508.9098.9.camel@sage.wic.aeroflex.com>
References: <bug-12447-10286@http.bugzilla.kernel.org/>
	 <20090114102838.3232cec8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:54579 "EHLO
	SG2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667AbZANXIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 18:08:34 -0500
In-Reply-To: <20090114102838.3232cec8.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Wed, 2009-01-14 at 10:28 -0800, Andrew Morton wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
OK, you asked for it - no fair complaining about the email wart that I
can do nothing about.

> On Wed, 14 Jan 2009 08:29:31 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> 
> Is this a USB thing, or an input thing?
> 

I'm not sure I understand the question. The problem is in the
usbtouchscreen kernel module, which is an input module.

The problem is NOT at the X layer (read: user space), but in the kernel
driver.

Did that answer the question?

(and here comes the wart - this gets added by our mail servers, and I
cannot do anything about it. The intended distribution of the email is
the world, so it has no application....)

Notice: This e-mail is intended solely for use of the individual or entity to which it is addressed and may contain information that is proprietary, privileged, company confidential and/or exempt from disclosure under applicable law. If the reader is not the intended recipient or agent responsible for delivering the message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited.  If this communication has been transmitted from a U.S. location it may also contain data subject to the International Traffic in Arms Regulations or U.S. Export Administration Regulations and cannot be disseminated, distributed or copied to foreign nationals, residing in the U.S. or abroad, without the prior approval of the U.
 S. Department of State or appropriate export licensing authority. If you have received this communication in error, please notify the sender by reply e-mail or collect telephone call and del
 ete or destroy all copies of this e-mail message, any physical copies made of this e-mail message and/or any file attachment(s).


