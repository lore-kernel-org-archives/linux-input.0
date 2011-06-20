From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 22/25] sony-laptop: forward Hybrid GFX notifications to
 userspace
Date: Mon, 20 Jun 2011 23:12:50 +0200
Message-ID: <4DFFB7D2.3080400@absence.it>
References: <4DE8FC4A.9010401@absence.it> <4DE93584.3070205@absence.it> <20110604084820.GE7194@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110604084820.GE7194@kamineko.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Il 04/06/2011 10:48, Mattia Dongili ha scritto:
> On Fri, Jun 03, 2011 at 09:27:00PM +0200, Marco Chiappero wrote:
>> Some Vaios come with both integrated and discrete graphics, plus a
>> switch for choosing one of the two. When the switch position is
>> changed, a notification is generated, now forwarded to userspace for
>> example for visual notifications, user scripts, and so on.

[...]

>> +		case 0x0128:
>> +		case 0x0146:
>> +			/* Hybrid GFX switching, 1 */
>> +			sony_call_snc_handle(handle, 0x0000,&result);
>> +			dprintk("sony_nc_notify, Hybrid GFX event received "
>> +					"(reason: %s)\n", (result&  0x01) ?
>> +					"switch position change" : "unknown");
>> +
>> +			/* verify the switch state
>> +			   (1: discrete GFX, 0: integrated GFX)*/
>> +			result = 0;
>> +			sony_call_snc_handle(handle, 0x0100,&result);
>> +
>> +			ev = 5;
>> +			value = result&  0xff;
>> +			break;
>
> shouldn't this be reported as an input event rather than just an acpi
> one?

If so, please someone let me know which keys to use.
