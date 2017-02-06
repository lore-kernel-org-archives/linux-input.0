From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/10] Add binding from PS/2 to SMBus for Synaptics and
 Elan
Date: Mon, 6 Feb 2017 11:27:42 -0800
Message-ID: <20170206192742.GB17441@dtor-ws>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
 <CAN+gG=E=wBWNhw7hPDVZPAUUKWP8-CxU0-sKZwXHghW2ODNeyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36104 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdBFT1q (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2017 14:27:46 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=E=wBWNhw7hPDVZPAUUKWP8-CxU0-sKZwXHghW2ODNeyA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>, Adrian Alves <aalves@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Hi Benjamin,

On Mon, Jan 30, 2017 at 02:05:39PM +0100, Benjamin Tissoires wrote:
> Hi Dmitri,
> 
> On Tue, Jan 10, 2017 at 5:11 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > Hi,
> >
> > Well, this is the last series which enables RMI4 over SMBus for the Thinkpad
> > t*40, t*50, t*60 series. Few comments on the patches:
> >
> > patches 1 to 3 allows the re-routing of the trackstick buttons from the touchpad
> >   to the trackstick
> > patch 4 to 7 allow rmi_smbus to actually control the PS/2 node to not resume and
> >   mess up the configuration after a resume
> > patch 8 was originally sent as a RMI4 specific driver, but I came to realise
> >   that Elan could also benefit from the same driver
> 
> Any comments on the first 8 patches?

I think that by trying to "unwind" unsuccessful SMbus initialization you
make the code much more complicated and fragile. I think we should
select a path (PS/2 or SMbus) and commit to it. If we commit to SMBus
then we need to communicate that fact to psmouse core so that it does
not create input devices or psmouse attributes, and "short-circuit" the
reconnect() routines to simply ignore requests and always report
success.

Thanks.

-- 
Dmitry
