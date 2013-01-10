From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V4 0/4] input: keyboard: tegra: cleanups and DT supports
Date: Thu, 10 Jan 2013 12:01:23 +0530
Message-ID: <50EE603B.7080702@nvidia.com>
References: <1357470900-12619-1-git-send-email-ldewangan@nvidia.com> <50EAFD36.9070909@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <50EAFD36.9070909@wwwdotorg.org>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Monday 07 January 2013 10:22 PM, Stephen Warren wrote:
> On 01/06/2013 04:14 AM, Laxman Dewangan wrote:
>> This patch series:
>>   - fix build warning,
>>   - use devm_* for allocation,
>>   - make column/rows configuration through DT and
>>   - remove the rarely used  key mapping table.
> The series,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>

If you are fine with this series then can it be apply please? I can 
handle if there is any comment on this series to close this.

Thanks,
Laxman

