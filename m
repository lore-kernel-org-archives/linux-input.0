From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/3] Input - soc_button_array: use gpio_is_valid()
Date: Tue, 10 May 2016 18:33:10 +0200
Message-ID: <20160510163310.GQ23234@mail.corp.redhat.com>
References: <1462894673-26560-1-git-send-email-benjamin.tissoires@redhat.com>
 <1462894673-26560-2-git-send-email-benjamin.tissoires@redhat.com>
 <CAOMZO5Avvy1BicUD-SwvUofpLtcEVyZHoceXSibq9wd1i7fX5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Avvy1BicUD-SwvUofpLtcEVyZHoceXSibq9wd1i7fX5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Alexandre Courbot <acourbot@nvidia.com>, Lejun Zhu <lejun.zhu@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On May 10 2016 or thereabouts, Fabio Estevam wrote:
> On Tue, May 10, 2016 at 12:37 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> 
> > @@ -92,7 +93,7 @@ soc_button_device_create(struct platform_device *pdev,
> >                         continue;
> >
> >                 gpio = soc_button_lookup_gpio(&pdev->dev, info->acpi_index);
> > -               if (gpio < 0)
> > +               if (gpio_is_valid(gpio))
> 
> Shouldn't it be "if (!gpio_is_valid(gpio))" ?

Oops, indeed. I messed up between the various trees as it's not that
convenient to recompile a full kernel on an atom device. Will fix this
in v2.

Cheers,
Benjamin
