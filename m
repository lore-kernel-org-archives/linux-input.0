From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V4 2/5] input: keyboard: imx_sc: Add i.MX system
 controller key support
Date: Mon, 23 Sep 2019 02:43:04 +0000
Message-ID: <DB3PR0402MB39164F6EB8141BA5CC4F26FCF5850@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1568602373-14164-1-git-send-email-Anson.Huang@nxp.com>
 <1568602373-14164-2-git-send-email-Anson.Huang@nxp.com>
 <20190916235330.GI237523@dtor-ws>
 <DB3PR0402MB3916859326C76BC9BC1F781CF58F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190922161432.GE1999@bug>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190922161432.GE1999@bug>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Jacky Bai <ping.bai@nxp.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Peng Fan <peng.fan@nxp.com>, "stefan@agner.ch" <stefan@agner.ch>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, "will@kernel.org" <will@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "ronald@innovation.ch" <ronald@innovation.ch>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.>
List-Id: linux-input@vger.kernel.org

Hi, Pavel

> Subject: Re: [PATCH V4 2/5] input: keyboard: imx_sc: Add i.MX system
> controller key support
> 
> Hi!
> 
> > > > +	ret = imx_scu_call_rpc(priv->key_ipc_handle, &msg, true);
> > > > +	if (ret) {
> > > > +		dev_err(&input->dev, "read imx sc key failed, ret %d\n", ret);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	state = (bool)msg.state;
> > > > +
> > > > +	if (!state && !priv->keystate)
> > > > +		state = true;
> > >
> > > This needs an explanation please.
> >
> > This is to handle the quick press of button, e.g., when button is
> > pressed and released very quickly, when the delay work is scheduled,
> > the button state read from SCU FW is actually a release state (0), the press
> state is (1), so the quick press/release will be ignored.
> >
> > However, after double check and test, I think this should be handled
> > by debounce time, if the button is pressed/release very quickly, the
> > event should be ignored, I will remove it and reduce the debounce time to
> 30mS, previous 100mS is too long, using 30mS as debounce time, I did NOT
> see similar issue no matter how quick I press/release the button.
> 
> Are you sure this is expected behaviour?
> 
> AFAIK microswitches can bounce when the button is pressed and released,
> but will not generate glitches when the button was not pressed, so even
> short presses are real and should be propagated...

Latest version of patch handle the quick press as below:

- When the button is pressed, the delayed work will be scheduled;
- In the delayed work, the button state will be read, once the state is different as previous
  state, it will be propagated;
- If the state is a press state, another delayed work will be scheduled for handling release
  event.

So there could be a small window of DEBOUNCE_TIME (30mS) between button press and the delayed
work scheduled for reading the button state, if the button is released in less than 30ms, then the
state read could be a release state which is same as previous state and it will be ignored.

Do you think in this case, we should also propagated the press event? If yes, then what about the
release event? Although from what I tested, no matter how quick I press the button, the driver
can always receive both the press and release event, as the 30mS is very short.

Thanks,
Anson 
