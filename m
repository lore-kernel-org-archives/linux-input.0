From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/2] HID: huion: enable button mode reporting
Date: Wed, 18 Feb 2015 14:17:46 +0200
Message-ID: <54E482EA.7070507@gmail.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com> <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:45206 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbBRMRv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 07:17:51 -0500
In-Reply-To: <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/18/2015 12:54 AM, Benjamin Tissoires wrote:
> @@ -81,6 +84,31 @@ static const __u8 huion_tablet_rdesc_template[] = {
>   	HUION_PH(PRESSURE_LM),  /*          Logical Maximum (PLACEHOLDER),  */
>   	0x81, 0x02,             /*          Input (Variable),               */
>   	0xC0,                   /*      End Collection,                     */
> +	0x05, 0x01,             /*      Usage Page (Desktop)                */
> +	0x09, 0x07,             /*      Usage (Keypad)                      */
> +	0xa1, 0x01,             /*      Collection (Application)            */
> +	0x85, 0x08,             /*          Report ID (8)                   */

Oh, and it's probably safer to have a higher-number report ID in case some
tablets use it for something else.

> +	0x05, 0x0d,             /*          Usage Page (Digitizers)         */
> +	0x09, 0x22,             /*          Usage (Finger)                  */
> +	0xa0,                   /*          Collection (Physical)           */
> +	0x14,                   /*              Logical Minimum (0)         */
> +	0x25, 0x01,             /*              Logical Maximum (1)         */
> +	0x75, 0x08,             /*              Report Size (8)             */
> +	0x95, 0x03,             /*              Report Count (3)            */
> +	0x81, 0x03,             /*              Input (Cnst,Var,Abs)        */
> +	0x05, 0x09,             /*              Usage Page (Button)         */
> +	0x19, 0x01,             /*              Usage Minimum (1)           */
> +	0x29, 0x08,             /*              Usage Maximum (8)           */
> +	0x14,                   /*              Logical Minimum (0)         */
> +	0x25, 0x01,             /*              Logical Maximum (1)         */
> +	0x75, 0x01,             /*              Report Size (1)             */
> +	0x95, 0x08,             /*              Report Count (8)            */
> +	0x81, 0x02,             /*              Input (Data,Var,Abs)        */
> +	0x75, 0x08,             /*              Report Size (8)             */
> +	0x95, 0x03,             /*              Report Count (3)            */
> +	0x81, 0x03,             /*              Input (Cnst,Var,Abs)        */
> +	0xc0,                   /*          End Collection                  */
> +	0xc0,                   /*      End Collection                      */
>   	0xC0                    /*  End Collection                          */
>   };

Nick
