From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] Input: rotary_encoder cleanup
Date: Thu, 9 Jul 2009 12:31:36 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A68B82@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com> <20090701183347.GB9464@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com> <20090708065650.GG3309@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A689B9@mi8nycmail19.Mi8.com> <20090709041751.GA10415@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og103.obsmtp.com ([64.18.1.185]:53123 "HELO
	exprod6og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758410AbZGIQbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 12:31:40 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090709041751.GA10415@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Wednesday, July 08, 2009 9:18 PM, Dmitry Torokhov wrote:
>>> Hmm, what axis will they be reporting though? Seems like very
>>> specialized [ab]use if they all share the same input device...
>> 
>> Each encoder reports as a unique axis.  They just all share one
>> input device.
>> 
>
> Well, if they truly represent X and Y axes then sharing the same
> input device is proper. However if you are using single input
> just to simplify userspace application and events reported do
> not really represent movement for the axis specified - that would
> be bad.

I agree.  Trying to report two of the same axis over a single input
would be a major abuse of the api.

Reporting multiple axis' over a single input should be doable.  I
just need to work out how to modify the rotary_encoder driver to
support it...

Thanks,
Hartley
