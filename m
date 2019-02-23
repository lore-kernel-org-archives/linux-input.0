From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
Date: Sat, 23 Feb 2019 13:38:01 +0200
Message-ID: <41befcd7-5ca4-34c9-6929-1ae1d706b108@mleia.com>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com> <20190223004158.GA3951@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190223004158.GA3951@bogus>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 02/23/2019 02:41 AM, Rob Herring wrote:
> On Sat, 26 Jan 2019 16:29:19 +0200, Vladimir Zapolskiy wrote:
>> The keypad controller on NXP LPC32xx requires its clock gate to be open,
>> therefore add description of the requires 'clocks' property.
>>
>> In addition adjust the example by adding description of required 'clocks'
>> property and by fixing 'interrupts' property.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

can you please pull this documentation change through Linux input branch?

The two other dts changes have been already included into arm-soc.

--
Best wishes,
Vladimir
