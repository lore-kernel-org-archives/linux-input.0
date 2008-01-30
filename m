From: "Bryan Wu" <cooloney.lkml@gmail.com>
Subject: Re: [PATCH 1/1] [INPUT] keypad driver: Added support for OpenCores Keyboard Controller
Date: Thu, 31 Jan 2008 01:07:52 +0800
Message-ID: <386072610801300907t5c0ee532tbe5696d48dad6b5c@mail.gmail.com>
References: <1201686610-31458-1-git-send-email-bryan.wu@analog.com>
	 <87a5b0800801300353l196b39bekad6af6ccdbd49d5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762781AbYA3RIL@vger.kernel.org>
In-Reply-To: <87a5b0800801300353l196b39bekad6af6ccdbd49d5b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Bryan Wu <bryan.wu@analog.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>
List-Id: linux-input@vger.kernel.org

On Jan 30, 2008 7:53 PM, Will Newton <will.newton@gmail.com> wrote:
> On Jan 30, 2008 9:50 AM, Bryan Wu <bryan.wu@analog.com> wrote:
>
> > +config KEYBOARD_OPENCORES
> > +       tristate "OpenCores Keyboard Controller"
> > +       help
> > +         Say Y here if you want to use the OpenCores Keyboard Controller
> > +         http://www.opencores.org/projects.cgi/web/keyboardcontroller/overview
> > +
> > +         To comile this driver as a module, choose M here. the
> > +         module will be called opencores-kbd.
> > +
>
> Typo, "comile" should be "compile" here.
>

Thanks, fix it now. I will update this patch soon.

-Bryan
