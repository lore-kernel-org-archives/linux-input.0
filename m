From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH next 09/25] input: keyboard: Use dev_get_drvdata()
Date: Tue, 23 Apr 2019 08:44:18 +0000
Message-ID: <20190423084418.sekqt5jeiqctvofe@penguin>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-10-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423075020.173734-10-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Kefeng,

On Tue, Apr 23, 2019 at 03:50:04PM +0800, Kefeng Wang wrote:
> Using dev_get_drvdata directly.

This assumes that generic device's driver data is exactly the same as platform
device's driver data. This is true today, but does not have to be true
tomorrow.

What is the benefit of violating the layering and accessing "parent"
object's abstraction directly? Performance impact must be negligible...

Thanks.

-- 
Dmitry
