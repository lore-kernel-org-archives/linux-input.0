From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] arm: exynos4: fix incorrect pad configuration for keypad
 row lines
Date: Sun, 4 Sep 2011 16:07:47 +0530
Message-ID: <CAJuYYwT1jXs4pYHnww=T5G_92=OU=08ef8UnJWjvz33Ted9wnQ@mail.gmail.com>
References: <1315129244-26489-1-git-send-email-thomas.abraham@linaro.org>
	<20110904105301.01b82323@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110904105301.01b82323@lxorguk.ukuu.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Alan,

On 4 September 2011 15:23, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> SMDKV310 board does not have pull-up resistors populated for the keypad
>> row lines (unlike the smdk boards for the previous Samsung SoC's). So
>> the pad pull-up for all keypad row lines should be enabled for
>> smdkv310 board.
>
> So does this change the behaviour of existing boards, and if so isn't it
> the SMDKV310 that hould be providing the alternate gpio configuration
> function ?

Among the boards based on the Exynos4 SoC, only the smdk boards use
the keypad controller for connecting the keys on the board. All other
boards either use gpio keys or use some other mechanism for keyboard
input. So this patch is applicable to only the existing exynos4 soc
based smdk boards.

A pull-up for all the row lines is the default requirement of the
keypad controller. So, in this patch, the default gpio and pad
configuration function for keypad controller enables the internal pad
pull-up. If a upcoming board based on exynos4 does populate pull-up
for row lines on the board of the keypad, this patch would still not
break anything. If required, such boards could provide another gpio
and pad configuration function that disables the internal pull-up.

This patch modifies only the exynos4 keypad gpio/pad configuration
setup function. All previous Samsung SoC's are not affected by this
patch.

Thanks,
Thomas.

>
>
