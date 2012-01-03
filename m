From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: tegra-kbc - add device tree support
Date: Tue, 03 Jan 2012 15:21:35 -0800
Message-ID: <2662846.nxkJH3EzFi@dtor-d630.eng.vmware.com>
References: <1325484557-27695-1-git-send-email-olof@lixom.net> <74CDBE0F657A3D45AFBB94109FB122FF17761F1203@HQMAIL01.nvidia.com> <CAOesGMhYscMgsNbZ+W0vdcRFmMiV3yQYLRxgGLfMVHKuhEAe-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMhYscMgsNbZ+W0vdcRFmMiV3yQYLRxgGLfMVHKuhEAe-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, January 03, 2012 02:58:57 PM Olof Johansson wrote:
> On Tue, Jan 3, 2012 at 2:42 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Olof Johansson wrote at Tuesday, January 03, 2012 3:28 PM:
> >> This includes an optional "linux,fn-keymap" binding that is not yet
> >> implemented, that will be used to specify the Fn-key modifier layout
> >> if needed.
> >> 
> >> diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt
> > 
> > ...
> > 
> >> +Required properties:
> >> +- compatible: "nvidia,tegra20-kbc", "matrix-keyboard-controller"
> > 
> > I think "matrix-keyboard-controller" should be dropped now?
> 
> Crap, yeah, I had dropped it but forgot to commit before I did send-email.
> 
> Dmitry, if this is the only comment, do you want me to resend or are
> you OK with editing yourself before applying?

Olof,

Any chance I could get a patch against my 'next' branch? I already applied
patch that did DT bindings without keymap support.

Thanks.

-- 
Dmitry
