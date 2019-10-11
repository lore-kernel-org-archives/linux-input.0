From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 3/4] HID: logitech: Add feature 0x0001: FeatureSet
Date: Fri, 11 Oct 2019 10:45:54 +0200
Message-ID: <CAO-hwJLAwodSXpz-_T0nGqnjHY3cVAu9GYjvp8SW8grTXX+VYg@mail.gmail.com>
References: <jCmT1QOunDmSu59iO1T1xj2-WfFeGhMn_i5knEWTCoph9VH1oxjpYf3Q6CWH7BRrq1NTVYBsAVJcIgu8azAEmFZJA8PzLfH3bHBcWNbFqeY=@protonmail.com>
 <CAO-hwJ+AMmNUOhas+vq6K4sRcCspyJuAefKO8oomAH4=CDHoJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+AMmNUOhas+vq6K4sRcCspyJuAefKO8oomAH4=CDHoJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 10:33 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Fri, Oct 11, 2019 at 2:57 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
> >
> > On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com>=
 wrote:
> >
> > > This patch adds support for the 0x0001 (FeatureSet) feature. This fea=
ture
> > > is used to look up the feature ID of a feature index on a device and =
list
> > > the total count of features on the device.
> > >
> > > I also added the hidpp20_get_features function which iterates through=
 all
> > > feature indexes on the device and stores a map of them in features an
> > > hidpp_device struct. This function runs when an HID++ 2.0 device is p=
robed.
> >
> > Changes in the version:
> >  - Renamed hidpp20_featureset_get_feature to
> >    hidpp20_featureset_get_feature_id.
> >
> >  - Re-ordered hidpp20_featureset_get_count and
> >    hidpp20_featureset_get_feature_id based on their command IDs.
> >
> >  - Made feature_count initialize to 0 before running hidpp20_get_featur=
es.
>
> I still need to decide whether or not we need to take this one. We
> historically did not do this to mimic the Windows driver at the time.
> However, the driver is full of quirks that could be detected instead
> of hardcoded thanks to this functions. So we might want to switch to
> auto-detection of those quirks so we can keep 'quirks' for actual
> defects that can't be auto-detected.
>
> But, if we want to go this route, we need to actually make use of it.
> So this patch should be part of a series where we use it, not added by
> its own.
>
> Can you drop it from the series?
> And maybe possibly work on a cleanup of some of the auto detection,
> like the HIDPP_QUIRK_HI_RES_SCROLL_X2121 which you can easily test?
> But this would need to happen in a second series, once this one gets
> merged in.

While reviewing 4/4, I realized why you need this one.
See my comments in 4/4, I still believe the case is not strong enough
to spend some time to enable the feature for barely no gain.

Cheers,
Benjamin
