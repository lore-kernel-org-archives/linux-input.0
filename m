From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: IS_INPUT_APPLICATION and tablets
Date: Thu, 21 May 2009 10:42:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905211038350.13917@wotan.suse.de>
References: <33210D89-9534-4B12-B7C3-E7FAEA3C4A5D@enac.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-182605341-1242895331=:13917"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54105 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbZEUImN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 04:42:13 -0400
In-Reply-To: <33210D89-9534-4B12-B7C3-E7FAEA3C4A5D@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: jirislaby@gmail.com, Greg KH <greg@kroah.com>, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-182605341-1242895331=:13917
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 20 May 2009, Stéphane Chatty wrote:

> I just saw a message in the linux-input ml about a USB tablet that is 
> not registered in the input layer. Someone proposed that there might be 
> no useful application in the HID report descriptors.
>
> There is an other possibility: the IS_INPUT_APPLICATION in hid.h might 
> fail to capture a legitimate application. I am currently working on a 
> HID driver for a multitouch surface by Stantum that has application 
> usage 0x000d0004 (Digitizer / Touchscreen), and I had to change 
> IS_INPUT_APPLICATION to have it registered in the input layer. The 
> N-Trig surface is registered only because it declares two application 
> collections: a Pen and a Touchscreen.
> 
> The comment that accompanies the definition of the macro looks very old. 
> Is there another reason why the definition of input applications is so 
> restrictive? I had in mind to add the range 0x000d0002-0x000d0006 at 
> least. Is there any contraindication to this?

Hi Stephane,

we definitely want to extend the IS_INPUT_APPLICATION() macro to reflect 
the current hardware -- the contants used in the macro are quite old 
indeed.

On the other hand we must be careful not to break any userspace drivers -- 
because currently hiddev node (which userspace drivers use) is created 
when the device has at least one application which is not recognized as 
input application by IS_INPUT_APPLICATION macro.

If we change semantics of this macro, it might happen that hiddev node 
would stop appearing for certain devices, thus breaking backwards 
compatibility for userspace drivers.

-- 
Jiri Kosina
SUSE Labs
--168427776-182605341-1242895331=:13917--
