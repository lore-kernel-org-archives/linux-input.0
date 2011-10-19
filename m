From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH RESEND] input: keyboard: adp5589-keys: Add support for
 the ADP5585 derivatives
Date: Wed, 19 Oct 2011 08:08:02 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E756759C@LIMKCMBX1.ad.analog.com>
References: <1318486726-6425-1-git-send-email-michael.hennerich@analog.com>
 <20111019042613.GA3077@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:35169
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751639Ab1JSHJ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Oct 2011 03:09:59 -0400
In-Reply-To: <20111019042613.GA3077@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>

Dmitry Torokhov wrote on 2011-10-19:
> Hi Michael,
>
> On Thu, Oct 13, 2011 at 08:18:46AM +0200, michael.hennerich@analog.com
> wrote:
>>  static void __devinit adp5589_report_switch_state(struct adp5589_kpad
>>  *kpad) {
>> -    int gpi_stat1 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_A);
>> -    int gpi_stat2 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_B);
>> -    int gpi_stat3 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_C);
>> -    int gpi_stat_tmp, pin_loc;
>> +    int gpi_stat_tmp, pin_loc, gpi_stat3;
>>      int i;
>> +    int gpi_stat1 = adp5589_read(kpad->client,
>> +                                 kpad->var->reg(ADP5589_GPI_STATUS_A));
>> +    int gpi_stat2 = adp5589_read(kpad->client,
>> +                                 kpad->var->reg(ADP5589_GPI_STATUS_B));
>> +    if (!kpad->is_adp5585)
>> +            gpi_stat3 = adp5589_read(kpad->client,
> ADP5589_GPI_STATUS_C);
>
> This cause my compiler to complain that gpi_stat3 might be used
> uninitialized; I changed it to
>
>       int gpi_stat3 = !kpad->is_adp5585 ?
>                       adp5589_read(kpad->client, ADP5589_GPI_STATUS_C) : 0;
>
> and applied.
>
> Thanks.

That works - Thanks!

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


