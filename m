From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH v2] input: add synaptics_i2c driver
Date: Tue, 02 Jun 2009 08:40:52 +0300
Message-ID: <4A24BB64.2050804@compulab.co.il>
References: <4A13F941.7040301@compulab.co.il> <20090520144949.15fa457b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:41337 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbZFBFky (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jun 2009 01:40:54 -0400
In-Reply-To: <20090520144949.15fa457b@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, grinberg <grinberg@compulab.co.il>, linux-input <linux-input@vger.kernel.org>

Hi Dmitry,
Any updates on this?

Jean Delvare wrote:
> On Wed, 20 May 2009 15:36:17 +0300, Mike Rapoport wrote:
>> This patch adds support for Synaptics i2c touchpad controller found on
>> eXeda machine.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> CC: Jean Delvare <khali@linux-fr.org>
>>
>> ---
>> v2 changelog:
>>   - fix bugs and issues pointed out by Jean and Dmitry
>>   - use workqueue instead of kthread
>>   - reorganize methods order to something more logical
>>
>> ---
>>  drivers/input/mouse/Kconfig         |   18 +
>>  drivers/input/mouse/Makefile        |    1 +
>>  drivers/input/mouse/synaptics_i2c.c |  700 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 719 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/input/mouse/synaptics_i2c.c
> 
> (I2C parts:)
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 

-- 
Sincerely yours,
Mike.

