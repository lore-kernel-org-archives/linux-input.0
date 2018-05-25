From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx
 vibrator documentation
Date: Fri, 25 May 2018 16:54:37 +0800
Message-ID: <CAMz4kuKsJkMNm0MJQ5_7STU8h-Mr0wGHtHFL8HPU3Mmhkqh1yQ@mail.gmail.com>
References: <44b17778d8f0bf897a316a39516ba2cafecf43c9.1525928437.git.baolin.wang@linaro.org>
 <20180518165408.GA31804@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518165408.GA31804@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, xiaotong.lu@spreadtrum.com
List-Id: linux-input@vger.kernel.org

On 19 May 2018 at 00:54, Rob Herring <robh@kernel.org> wrote:
> On Thu, May 10, 2018 at 01:08:33PM +0800, Baolin Wang wrote:
>> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> vibrator device.
>>
>> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v3:
>>  - Change compatible string to explicit Soc name.
>>  - Add parent MFD node.
>>
>> Changes since v2:
>>  - No updates.
>>
>> Changes since v1:
>>   - No updates.
>> ---
>>  .../bindings/input/sprd,sc27xx-vibra.txt           |   23 ++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Hi Dmitry,

Could you apply this patch set if there are no other issues? Thanks.

-- 
Baolin.wang
Best Regards
