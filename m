From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH hisi] Input: i2c_atmel_read() can be static
Date: Sun, 21 Dec 2014 19:29:45 +0800
Message-ID: <5496AF29.3060802@linaro.org>
References: <201412190926.IzkyYvvl%fengguang.wu@intel.com> <20141219015659.GA49367@snb.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141219015659.GA49367@snb.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "xuwei (O)" <xuwei5@hisilicon.com>
List-Id: linux-input@vger.kernel.org



On 12/19/2014 09:56 AM, kbuild test robot wrote:
> drivers/input/touchscreen/atmel_mXT224E.c:460:5: sparse: symbol 'i2c_atmel_read' was not declared. Should it be static?
> drivers/input/touchscreen/atmel_mXT224E.c:496:5: sparse: symbol 'i2c_atmel_write' was not declared. Should it be static?
> drivers/input/touchscreen/atmel_mXT224E.c:532:5: sparse: symbol 'i2c_atmel_write_byte_data' was not declared. Should it be static?
> drivers/input/touchscreen/atmel_mXT224E.c:538:10: sparse: symbol 'get_object_address' was not declared. Should it be static?
> drivers/input/touchscreen/atmel_mXT224E.c:547:9: sparse: symbol 'get_object_size' was not declared. Should it be static?
> drivers/input/touchscreen/atmel_mXT224E.c:557:9: sparse: symbol 'get_object_size_from_address' was not declared. Should it be static?
> drivers/input/touchscreen/atmel_mXT224E.c:847:32: sparse: symbol 'atmel_ts_get_pdata' was not declared. Should it be static?
>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Thanks Fengguang for the patch, will take it.

However, the file drivers/input/touchscreen/atmel_mXT224E.c is not used 
for mainline kernel.

Xuwei will remove git://github.com/hisilicon/linux-hisi 
integration-hilt-linux-linaro.
Sorry for the confusion.

Thanks
