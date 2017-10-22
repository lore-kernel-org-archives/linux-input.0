From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Xorg doesn't find input devices with "Input: allow matching
 device IDs on property bits" applied
Date: Sun, 22 Oct 2017 12:45:59 -0700
Message-ID: <20171022194559.ucsnrk4t2i5o3fsx@dtor-ws>
References: <83e020ff-959e-9a75-5bab-380c7e1373b0@internode.on.net>
 <b292dade-a0fe-c012-4b87-de15c9bf82cf@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:46331 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdJVTqD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Oct 2017 15:46:03 -0400
Content-Disposition: inline
In-Reply-To: <b292dade-a0fe-c012-4b87-de15c9bf82cf@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Arthur Marsh <arthur.marsh@internode.on.net>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Oct 22, 2017 at 12:33:42PM -0700, Randy Dunlap wrote:
> On 10/22/17 12:32, Arthur Marsh wrote:
> > After a recent git pull and kernel build and reboot, Xorg could not find the input devices and I was left with unresponsive mouse and keyboard until I could remotely shut-down and boot into an earlier kernel.
> > 
> > With good kernels, Xorg.log showed evdev finding the mouse and keyboard.
> > 
> > Bisecting lead to this commit:
> > 
> >  git bisect good
> > 8724ecb072293f109a6f5dc93be8a98bf61fe14f is the first bad commit
> > commit 8724ecb072293f109a6f5dc93be8a98bf61fe14f
> > Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Date:   Mon Oct 9 12:01:14 2017 -0700
> > 
> >     Input: allow matching device IDs on property bits
> > 
> >     Let's allow matching input devices on their property bits, both in-kernel
> >     and when generating module aliases.
> > 
> >     Tested-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> >     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > :040000 040000 4192943bfd5affbe9e86c14efd690bda5c90bd82 d30b9d9c3a7ed1a6078f56a3bec2a82e0ba09570 M      drivers
> > :040000 040000 d39ca313c8d6dc86ad1175bf9374c76d9c134e82 8717e17cbb0556629dd8cf7a7c34694dd299925c M      include
> > :040000 040000 ba4684d3706ca73868f39e90f673e3926e23e3ba 811ed0e561768778c86eefa4c5ea5f866a542156 M      scripts
> > 
> > I am happy to run further tests if needed.
> > 
> > Arthur.
> 
> Hi,
> See https://lkml.org/lkml/2017/10/22/125  for a patch.

Please do let me know if the patch works so I can push it forward.

Thanks.

-- 
Dmitry
