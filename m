From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/03] input: bitmap update for sh_keysc
Date: Mon, 8 Feb 2010 16:41:16 +0900
Message-ID: <aec7e5c31002072341i33ddc56cwde2776cf89a585c6@mail.gmail.com>
References: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
	 <20100208063234.2003.7539.sendpatchset@rxone.opensource.se>
	 <20100208071843.GA22911@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100208071843.GA22911@core.coreip.homeip.net>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Feb 8, 2010 at 4:18 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Feb 08, 2010 at 03:32:34PM +0900, Magnus Damm wrote:
>>
>> +#define WRAP(fn, m...) bitmap_##fn(m, SH_KEYSC_MAXKEYS)
>> +#define sh_keysc_map_zero(m) WRAP(zero, (m)->b)
>> +#define sh_keysc_map_fill(m) WRAP(fill, (m)->b)
>> +#define sh_keysc_map_and(m, m2) WRAP(and, (m)->b, (m)->b, (m2)->b)
>> +#define sh_keysc_map_or(m, m2) WRAP(or, (m)->b, (m)->b, (m2)->b)
>> +#define sh_keysc_map_complement(m) WRAP(complement, (m)->b, (m)->b)
>> +#define sh_keysc_map_set(m, n) set_bit((n), (m)->b)
>> +#define sh_keysc_map_clear(m, n) clear_bit((n), (m)->b)
>> +#define sh_keysc_map_test(m, n) test_bit((n), (m)->b)
>> +
>
> Why do you need these wrappers? For me they simply create a distraction,
> later when I read the code I will have to go and look up what
> sh_keysc_map_set() means but if I see __set_bit() I'd know right away.

To avoid duplicating SH_KEYSC_MAXKEYS all over the place I started out
by wrapping bitmap_zero/fill/and/or/complement(). To be consistent I
decided to wrap the set/clear/test_bit() functions as well, but it may
be better to leave them alone.

Are you ok with wrapping the bitmap_...() functions to avoid
duplicating SH_KEYSC_MAXKEYS?

Cheers,

/ magnus
