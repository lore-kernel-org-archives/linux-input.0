From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Mon, 25 Mar 2019 17:38:07 +0100
Message-ID: <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>, Vladislav Dalechyn <vlad.dalechin@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com, swboyd@chromium.org, bigeasy@linutronix.de, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 25-03-19 17:02, Dmitry Torokhov wrote:
> Hi Vladislav,
> 
> On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
> <vlad.dalechin@gmail.com> wrote:
>>
>> From: Vladislav Dalechyn <hotwater438@tutanota.com>
>>
>> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
>> caused by an error setting the correct IRQ_TRIGGER flag:
>> - i2c_hid incoplete error flood in journalctl;
>> - Five finger tap kill's module so you have to restart it;
>> - Two finger scoll is working incorrect and sometimes even when you
>> raised one of two finger still thinks that you are scrolling.
>>
>> Fix all of these with a new quirk that corrects the trigger flag
>> announced by the ACPI tables. (edge-falling).
> 
> I do not believe this is right solution. The driver makes liberal use
> of disable_irq() and enable_irq() which may lead to lost edges and
> touchpad stopping working altogether.
> 
> Usually the "extra" report is caused by GPIO controller clearing
> interrupt condition at the wrong time (too early), or in unsafe or
> racy fashion. You need to look there instead of adding quirk to
> i2c-hid.

The falling-edge solution was proposed by Elan themselves.

Also if you look at: https://bugzilla.redhat.com/show_bug.cgi?id=1543769

And esp. the "cat /proc/interrupts" output there, then you will see
that the interrupt seems to be stuck at low level, which according
to the ACPI tables is its active level.

As for this being a GPIO chip driver problem, this is using standard
Intel pinctrl stuff, which is not showing this same issue with many
other i2c-hid touchpads.

Regards,

Hans
