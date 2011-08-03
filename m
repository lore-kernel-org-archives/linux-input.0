From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] input: keyboard: adp5589-keys: Add support for the ADP5585
 derivatives
Date: Wed, 3 Aug 2011 10:30:08 +0200
Message-ID: <4E390710.5060503@analog.com>
References: <1311944415-20197-1-git-send-email-michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:47496
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935Ab1HCIbB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Aug 2011 04:31:01 -0400
In-Reply-To: <1311944415-20197-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>

On 07/29/2011 03:00 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
>
> The ADP5585 family keypad decoder and IO expander is similar to the ADP5589,
> however it features less IO pins, and lacks hardware assisted key-lock
> functionality. Unfortunately the register addresses are different, as well as
> the event codes and bit organization within the port related registers.
>
> Move ADP5589 Register defines from the header file into the main source file.
> Add new defines while making sure we don't break existing platform_data.
> Add register address translation, and turn device specific defines into variables.
> Introduce some helper functions and disable functions that doesn't
> exist on the added devices.
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> ---
>   drivers/input/keyboard/Kconfig        |    4 +-
>   drivers/input/keyboard/adp5589-keys.c |  607 ++++++++++++++++++++++++++-------
>   include/linux/input/adp5589.h         |  157 ++++-----
>   3 files changed, 549 insertions(+), 219 deletions(-)
>
Hi Dmitry,

If you prefer support for the ADP5585 as separate driver, please let me 
know.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


