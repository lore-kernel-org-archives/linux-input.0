From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Wed, 28 Mar 2012 15:28:01 -0600
Message-ID: <4F738261.1060002@wwwdotorg.org>
References: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com> <4F71E0A6.4080703@wwwdotorg.org> <4F7299D7.4020006@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56719 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933025Ab2C1V2G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 17:28:06 -0400
In-Reply-To: <4F7299D7.4020006@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "sr@denx.de" <sr@denx.de>

On 03/27/2012 10:55 PM, Viresh Kumar wrote:
> On 3/27/2012 9:15 PM, Stephen Warren wrote:
>>>>  static int __devinit tegra_kbc_probe(struct platform_device *pdev)
>> ...
>>>> +	if (pdev->dev.of_node) {
>>>> +		/* FIXME: Add handling of linux,fn-keymap here */
>>>> +		err = matrix_keypad_of_build_keymap(&pdev->dev, KBC_ROW_SHIFT,
>>>> +				input_dev->keycode, input_dev->keybit,
>>>> +				"linux,keymap");
>>
>> Where do input_dev->keycode/keybit get allocated? As far as I can tell,
>> matrix_keypad_of_build_keymap() just writes to those and assumes they're
>> already allocated.
> 
> If i am not reading the code incorrectly, keycode is allocated memory with
> kbc. And then we do this:
> 
> 	input_dev->keycode = kbc->keycode;
> 
> keybit is again present as part of struct input_dev.
> Am i missing something.

Ah right, I'd been looking inside input_allocate_device() rather than
the specific driver's probe(). So, no issue here.

>>>> diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
>> ...
>>>> +int matrix_keypad_of_build_keymap(struct device *dev, unsigned int row_shift,
>> ...
>>>> +		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
>>>> +		__set_bit(code, keybit);
>> How bit are keymap and keybit?
> 
> Couldn't get this one. :(
> Can you please elaborate the question a bit?

s/bit/big/ might make the question clearer:-)

>> I think we need range-checking here to
>> make sure that row/col/row_shift/code are valid and in-range.
> 
> I picked this directly from matrix_keypad_build_keymap() as is.
> Anyway there is no loss in improving it. :)
> 
> What kind of range-check you are looking for?
> Currently we do following
> 
> 		unsigned int row = KEY_ROW(key);
> 		unsigned int col = KEY_COL(key);
> 		unsigned short code = KEY_VAL(key);
> 
> All these macros '&' 'key' with 0xFF, 0xFF and 0xFFFF.
> Which is also kind of range checking.

The size of the keycode array is much smaller though:

mach-tegra's kbc.h:

#define KBC_MAX_ROW	16
#define KBC_MAX_COL	8
#define KBC_MAX_KEY	(KBC_MAX_ROW * KBC_MAX_COL)

tegra-kbc.c:

struct tegra_kbc {
...
	unsigned short keycode[KBC_MAX_KEY * 2];

so the DT parsing can easily overflow this, and is driven by
user-supplied data. I think you'll need to pass input_dev->keycodesize
into matrix_keypad_of_build_keymap() to achieve the overall
range-checking, but also checking col against (1<<row_shift) would be
needed to make sure the individual "fields" of the array index don't
overflow too.
