From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] HID: hid-ntrig: use true and false for boolean values
Date: Tue, 6 Mar 2018 10:50:13 -0600
Message-ID: <28d2c1a8-2ef3-c8cb-6fed-b29bc4b68f0e@embeddedor.com>
References: <20180306000624.GA2680@embeddedgus>
 <nycvar.YFH.7.76.1803061519430.15778@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1803061519430.15778@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

On 03/06/2018 08:20 AM, Jiri Kosina wrote:
> On Mon, 5 Mar 2018, Gustavo A. R. Silva wrote:
> 
>> Assign true or false to boolean variables instead of an integer value.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I've commited this (and the hid-multitouch variant of it as well) to
> for-4.17/upstream.
> 

Good to know.

Thanks
--
Gustavo
