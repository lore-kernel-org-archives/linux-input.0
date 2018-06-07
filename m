From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - Add "GDIX1002" ACPI HID
Date: Thu, 07 Jun 2018 11:55:22 +0200
Message-ID: <bf3b59ab09673826005faf87db1df81d30dba209.camel@hadess.net>
References: <20180607093640.8103-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180607093640.8103-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2018-06-07 at 11:36 +0200, Hans de Goede wrote:
> Some newer devices with a goodix touchscreen use GDIX1002 as ACPI HID
> rather then GDIX1001. These devices work fine with the goodix driver
> as is.
> 
> This commit adds the new "GDIX1002" ACPI HID to make the touchscreen
> work on these devices.

Ethan Lee sent this one about a week ago, along with a fix for the
joysticks.

If you want, you can however follow-up on that patch to remove the i2c
struct above the acpi match tablet, that'd be appreciated :)
