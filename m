From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 02/12] ALSA: ac97: add an ac97 bus
Date: Wed, 05 Jul 2017 22:21:39 +0200
Message-ID: <877ezmtz1o.fsf@belgarion.home>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-3-robert.jarzmik@free.fr>
 <s5hpodhc28v.wl-tiwai@suse.de> <87bmp0t2lv.fsf@belgarion.home>
 <s5hbmp0c6a3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hbmp0c6a3.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
 04 Jul 2017 22:10:28 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> On Tue, 04 Jul 2017 21:37:48 +0200,
> Robert Jarzmik wrote:
>> 
>> Takashi Iwai <tiwai@suse.de> writes:
>> 
>> > On Fri, 30 Jun 2017 21:43:58 +0200,
>> > Robert Jarzmik wrote:
>> >> +static struct bus_type ac97_bus_type = {
>> >> +	.name		= "ac97",
>> >
>> > Name-conflict with the old ac97 bus?
>> Yeah, fair point. So what should I choose for this new one ?
>>  - ac97new
>>  - ac97bis
>>  - ac97_2
>>  - ac97reborn
>
> ac97bus
> ac97_episode_5
> ac98
> ...
>
> I have no opinion on it.
Ah clone wars one is really tempting :)
But let's have ac97bus actually.

> You can use subsys_init() for modules, it's no problem.
> When it's built for a module, all xxx_init() is handled as equivalent
> with module_init().  See linux/module.h.
>
> It's just the lack of module_exit() in your case.
Got it, I'll add it for v4.

Cheers.

-- 
Robert
