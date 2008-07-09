From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Wed, 9 Jul 2008 14:13:12 -0400
Message-ID: <d120d5000807091113n494485f2m66b22a0b9897b395@mail.gmail.com>
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
	 <878wwcsqcm.fsf@macbook.be.48ers.dk>
	 <20080709161408.55E0F4A006C@mail60-va3.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.179]:48263 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYGISNP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2008 14:13:15 -0400
Received: by el-out-1112.google.com with SMTP id z25so497109ele.1
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2008 11:13:12 -0700 (PDT)
In-Reply-To: <20080709161408.55E0F4A006C@mail60-va3.bigfish.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org, grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com, Sadanand Mutyala <sadanan@xilinx.com>

On Wed, Jul 9, 2008 at 12:14 PM, John Linn <John.Linn@xilinx.com> wrote:
> These look like good comments from Peter.
>
> Dmitry, how would you like to do this, would you prefer us to do an
> incremental patch from the existing patch (V3)?  Or a new V4 for the
> patch?
>

Incremental please. I already committed V3 to the 'next' branch and I
don't want to rebuild it unless the patch is completely broken so
incremental cleanup is the way to go.

Thanks.

-- 
Dmitry
