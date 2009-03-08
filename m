From: Matthew Garrett <mjg@redhat.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sun, 8 Mar 2009 23:19:35 +0000
Message-ID: <20090308231935.GA32624@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org> <200903082156.46219.rjw@sisk.pl> <20090308230741.GA5357@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56032 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbZCHXTn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Mar 2009 19:19:43 -0400
Content-Disposition: inline
In-Reply-To: <20090308230741.GA5357@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Richard Hughes <hughsient@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Sun, Mar 08, 2009 at 04:07:50PM -0700, Dmitry Torokhov wrote:

> - KEY_SLEEP - leave the keycode, the action should be the default
> system state defined by either platform or user. I expect that the vast
> majority of system have default state similar to S3 so there should not
> be anysurprises.
> 
> - KEY_SUSPEND - provide better comment for its intended usage and maybe
> add KEY_HIBERNATE alias.
> 
> - KEY_SUSPEND2RAM - add a new definition.
> 
> Do you think this would this work?

I think that would be fine, though I'm not entirely convinced that we 
need KEY_SUSPEND2RAM as a separate keycode.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
