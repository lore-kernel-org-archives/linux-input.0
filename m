From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade
 Stealth
Date: Sun, 7 Apr 2019 15:10:34 -0700
Message-ID: <20190407221034.GA162359@dtor-ws>
References: <20190407213735.10658-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190407213735.10658-1-lyude@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Lyude,

On Sun, Apr 07, 2019 at 05:37:34PM -0400, Lyude Paul wrote:
> The late 2016 model of the Razer Blade Stealth has a built-in USB
> keyboard, but for some reason the BIOS exposes an i8042 controller with
> a connected KBD port. While this fake AT Keyboard device doesn't appear
> to report any events, attempting to change the state of the caps lock
> LED on it from on to off causes the entire system to hang.
> 
> So, introduce a quirk table for disabling keyboard probing by default,
> i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
> that table.

What does dmesg show about i8042 for this device? Especially line "PNP:
PS/2 Controller  ..."?

Thanks.

-- 
Dmitry
