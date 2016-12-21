From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] input: synaptics-rmi4: check for null rmi_dev before it
 is dereferenced
Date: Wed, 21 Dec 2016 14:41:51 +0000
Message-ID: <44f9b45f-544f-eb47-49f8-f794f0541b7f@canonical.com>
References: <20161220100750.8033-1-colin.king@canonical.com>
 <20161220212259.GA34190@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161220212259.GA34190@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 20/12/16 21:22, Dmitry Torokhov wrote:
> Hi Colin,
> 
> On Tue, Dec 20, 2016 at 10:07:50AM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> rmi_dev is currently being dereferenced before it null checked, so we
>> have a potential null pointer dereference issue with this.  Fix this
>> by dereferencing rmi_dev after a null check has been performed.
>>
>> Fixes CoverityScan CID 1391218 ("Dereference before null check")
> 
> I'd rather we removed the NULL check instead. As far as I can see it
> can't even be NULL.
> 
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/input/rmi4/rmi_f03.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
>> index 8a7ca3e..008f42a 100644
>> --- a/drivers/input/rmi4/rmi_f03.c
>> +++ b/drivers/input/rmi4/rmi_f03.c
>> @@ -164,7 +164,7 @@ static int rmi_f03_config(struct rmi_function *fn)
>>  static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
>>  {
>>  	struct rmi_device *rmi_dev = fn->rmi_dev;
>> -	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>> +	struct rmi_driver_data *drvdata;
>>  	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
>>  	u16 data_addr = fn->fd.data_base_addr;
>>  	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
>> @@ -178,6 +178,7 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
>>  	if (!rmi_dev)
>>  		return -ENODEV;
>>  
>> +	drvdata = dev_get_drvdata(&rmi_dev->dev);
>>  	if (drvdata->attn_data.data) {
>>  		/* First grab the data passed by the transport device */
>>  		if (drvdata->attn_data.size < ob_len) {
>> -- 
>> 2.10.2
>>
> 
> Thanks.
> 
Ignore this patch, correct fix just sent.
