From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: add delay time to device power on
Date: Thu, 11 Jul 2019 23:48:58 -0700
Message-ID: <20190712064858.GD150689@dtor-ws>
References: <20190710025859.6025-1-crag0715@gmail.com>
 <CAP-8N0hTEXkK3iqGP=+gtuVVcqo-+KYHC_N6+8Q90ndf_UVJpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-8N0hTEXkK3iqGP=+gtuVVcqo-+KYHC_N6+8Q90ndf_UVJpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Crag Wang <crag0715@gmail.com>
Cc: yjjung@melfas.com, jsj1012@melfas.com, leesh832@lgdisplay.com, Mario Limonciello <mario_limonciello@dell.com>, chrome.os.engineering@dell.com, "Crag.Wang" <crag.wang@dell.com>, Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Crag,

On Wed, Jul 10, 2019 at 04:58:40PM +0800, Crag Wang wrote:
> Adding more
> 
> On Wed, Jul 10, 2019 at 10:59 AM <crag0715@gmail.com> wrote:
> >
> > From: "Crag.Wang" <crag.wang@dell.com>
> >
> > Delay time for MELFAS MIP4 controller is required at power on stage
> > regardless the existence of GPIO consumer lookup from devicetree or
> > ACPI device table.
> >
> > There is an issue if GPIO ce is undefined in the ACPI results no delay
> > time for deive power on, the controller ended up in an abnormal state.
> >

If kernel does not reset the controller it should not have to wait for
reset to complete either. Since your firmware resets the controller it
also has to conform to the timing requirements.

Thanks.

-- 
Dmitry
