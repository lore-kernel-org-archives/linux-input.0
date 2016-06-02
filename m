From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v3 0/8] Input: atmel_mxt_ts - output raw touch diagnostic
 data via V4L
Date: Thu, 2 Jun 2016 16:14:10 +0100
Message-ID: <d8c40054-359c-5e21-6c1f-be38fd2368db@itdev.co.uk>
References: <1464799192-28034-1-git-send-email-nick.dyer@itdev.co.uk>
 <20160601181700.GD4114@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601181700.GD4114@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>, mchehab@osg.samsung.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry-

On 01/06/2016 19:17, Dmitry Torokhov wrote:
> On Wed, Jun 01, 2016 at 05:39:44PM +0100, Nick Dyer wrote:
>> This is a series of patches to add diagnostic data support to the Atmel
>> maXTouch driver. It's a rewrite of the previous implementation which output via
>> debugfs: it now uses a V4L2 device in a similar way to the sur40 driver.
>
> I do not have any objections other than some nits form the input side;
> majority of the review should come from V4L2 side here...

Thanks for the review. I've hopefully fixed the issues you raised and
pushed it to
    https://github.com/ndyer/linux/commits/diagnostic-v4l-20160602

I will wait for the V4L2 folks to comment before posting a [PATCH v4]

cheers

Nick
