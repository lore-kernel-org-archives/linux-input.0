From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
	option
Date: Mon, 12 Sep 2011 16:49:49 +0530
Message-ID: <CAJuYYwSyJ3pKDSYLtad5hDKER2cgxOGo-pC93dtXtLfybvs=+w@mail.gmail.com>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
	<20110907182248.GA2874@core.coreip.homeip.net>
	<CAJuYYwQg8pMaM7Y-AQD5eDqw32rMOHggL2gWOtJH_ri8gsH-yg@mail.gmail.com>
	<20110908163322.GB17503@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110908163322.GB17503@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, devicetree-discuss@lists.ozlabs.org, dh09.lee@samsung.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 8 September 2011 22:03, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrot=
e:
> On Thu, Sep 08, 2011 at 09:16:46AM +0530, Thomas Abraham wrote:
>> Hi Dmitry,
>>
>> On 7 September 2011 23:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> w=
rote:
>> > Hi Thomas,
>> >
>> > On Tue, Sep 06, 2011 at 07:25:16PM +0530, Thomas Abraham wrote:
>> >> Samsung keyboard driver could be used with platforms using device tre=
e.
>> >> So the inclusion of samsung keyboard driver cannot be based on
>> >> SAMSUNG_DEV_KEYPAD. A new config option HAVE_SAMSUNG_KEYPAD is added
>> >> which device tree based platforms should use to include samsung keybo=
ard
>> >> driver.
>> >
>> > I am sorry, I do not follow... What is the difference between
>> > SAMSUNG_DEV_KEYPAD and HAVE_SAMSUNG_KEYPAD? They look exactly the same.
>>
>> The inclusion of platform device instance for keypad (in
>> arch/arm/plat-samsung/dev-keypad.c) in the build depends on
>> SAMSUNG_DEV_KEYPAD. The samsung-keypad driver is also dependent on
>> SAMSUNG_DEV_KEYPAD.
>>
>> In case of device tree based instantiation of keypad, compilation of
>> dev-keypad.c file is not required. So SAMSUNG_DEV_KEYPAD config option
>> will not be selected.In that case, the compilation of the keypad
>> driver cannot be dependent on SAMSUNG_DEV_KEYPAD. There should be
>> another option to select the keypad driver and so HAVE_SAMSUNG_KEYPAD
>> was introduced. HAVE_SAMSUNG_KEYPAD can be selected on platforms that
>> need the samsung-keypad driver but do no need the keypad platform
>> device.
>
> I still think that it is an extra option... What about the following
> dependencies:
>
> =A0 =A0 =A0 =A0depends on SAMSUNG_DEV_KEYPAD || OF
> =A0 =A0 =A0 =A0depends on HAVE_CLK

There could be OF based Samsung platforms that might not need the
keypad controller driver to be compiled. And it could get selected for
non-samsung platforms using OF. So, this change would not provide the
intended dependencies.

>
> although I think we should relax dependencies like I did in my other
> patch. This will extend compile coverage of the driver and lessen the
> chances that API changes will cause unintended breakage because noone
> but Samsung platform users compile it.

The only concern with your patch was that Samsung keypad driver gets
listed even for non-samsung platforms. There is no particular
preference on this. But if you prefer to extend Samsung keypad
controller driver to other platforms as well, and if others agree,
that should be fine.

(Sorry for the delayed reply. I was out of office for three days.)

Thanks,
Thomas.

[...]
