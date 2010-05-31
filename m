From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
Date: Mon, 31 May 2010 10:14:02 +0900
Message-ID: <4C030D5A.1060609@samsung.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
 <201005300542.37715.marek.vasut@gmail.com>
 <20100530085224.GA28188@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100530085224.GA28188@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com
List-Id: linux-input@vger.kernel.org

On 5/30/2010 5:52 PM, Dmitry Torokhov wrote:
> On Sun, May 30, 2010 at 05:42:37AM +0200, Marek Vasut wrote:
>> Dne Ne 30. kv=ED=9C=8Etna 2010 05:06:20 Joonyoung Shim napsal(a):
>>> + */
>>> +struct samsung_kp_platdata {
>>> +	const struct matrix_keymap_data	*keymap_data;
>>> +	unsigned int		rows;
>>> +	unsigned int		cols;
>>> +	unsigned int		rep;
>> I don't know, maybe using uint32_t here? On ARM, it doesn't matter s=
o far as int=20
>> will be always 32bit, but maybe we should just type the variables we=
ll ?
>>
>> Guys, what do you think ?
>>
>=20
> I think unsigned int is fine, we do not care about particular size, j=
ust
> need "big enough". I'd change 'rep' to be a boolean though.
>=20

I will modify 'rep' to unsinged int rep:1;
