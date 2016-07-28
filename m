From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC v0 4/8] Input: goodix: use firmware_stat instead of
 completion
Date: Thu, 28 Jul 2016 14:20:50 +0200
Message-ID: <1469708450.6761.156.camel@hadess.net>
References: <1469692512-16863-1-git-send-email-wagi@monom.org>	
 <1469692512-16863-5-git-send-email-wagi@monom.org>	
 <1469704952.6761.142.camel@hadess.net>
	 <f7dd0db5-af15-7310-ac9f-1034bdf4f592@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7dd0db5-af15-7310-ac9f-1034bdf4f592@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>, Daniel Wagner <wagi@monom.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, irina.tirdea@intel.com, octavian.purdila@intel.com
List-Id: linux-input@vger.kernel.org

On Thu, 2016-07-28 at 13:59 +0200, Daniel Wagner wrote:
> On 07/28/2016 01:22 PM, Bastien Nocera wrote:
> > On Thu, 2016-07-28 at 09:55 +0200, Daniel Wagner wrote:
> > > From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> > >=20
> > > Loading firmware is an operation many drivers implement in
> > > various
> > > ways
> > > around the completion API. And most of them do it almost in the
> > > same
> > > way. Let's reuse the firmware_stat API which is used also by the
> > > firmware_class loader. Apart of streamlining the firmware loading
> > > states
> > > we also document it slightly better.
> > >=20
> > > Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> >=20
> > Irina added and tested that feature, so best for her to comment on
> > this, as I don't have any hardware that would use this feature.
>=20
> In case you have any comments on the API, let me know. I'll add Irina
> to=C2=A0
> the Cc list in the next version.

Looking at the API, I really don't like the mixing of namespaces.
Either it's fw_ or it's firmware_ but not a mix of both.

Also looks like=C2=A0fw_loading_start() would do nothing as the struct =
is
likely zero initialised, and=C2=A0FW_STATUS_LOADING =3D=3D 0. Maybe you=
 need an
UNSET enum member?

=46W_STATUS_ABORT <-=C2=A0FW_STATUS_ABORTED, to match the adjective suf=
fixes
of the other members. Ditto=C2=A0fw_loading_abort() which doesn't abort
firmware loading but sets the status.

Cheers
