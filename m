Received: from mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06744368D66
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194535; cv=none; b=CoaLYuy0vJ1nQer3H/xEEjAdpp8BnvDP3Z0oWruPWCEiAUS30WUwfIjfWHCG7uL7XsBYHPMF4sis0Cc3H1GGZfooxMKr3+sqT0KcAWxedTTzIj5sa8BEjY4yzhvRxv/ObxQODdwQBPshiTfmqrvJR0s1kJ/7hDzf4EDvT4k8WLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194535; c=relaxed/simple;
	bh=tdHcWsi0AaT2ukB84G+9Y6w92gG5pzB05rU1WCPqkkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q94pkPjVUdhUMsphT2DbMltCQ4orXQYIsXDcKCiiDJb5j95lRfZ8t7G6JXJYzkFNWgwk4eBNJYII9KY6lt0uWQCgEkY4dDuK0PH37HXJqzEeDKucMNCeHRYw8eblyKoCmYBJCBjpZo/WCDtxQIZ635MS+fEbxasJSd67r9z2Tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/bgbYZO; arc=none smtp.client-ip=95.215.58.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/bgbYZO"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tdHcWsi0AaT2ukB84G+9Y6w92gG5pzB05rU1WCPqkkM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788194531; v=1; x=1788799331;
 b=e/bgbYZO3CtzoAtgTXgEkj6oh2lTvqcDFoMARhIVTMa4ssFR6D4PLt7MQEkW9IrJmwE0z+C4
 odgP3NjRw7WJkVSY7SGEJOryYgpQ4NXmvlRXwTLrOzLZbMn1gx09HA0uSR3fBUhYEc6sY5zdBbN
 gbjGIq9NJ0c8xKQ0098yIpUo=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26a930ce5f2a0f09;
	Mon, 31 Aug 2026 16:42:01 +0000
X-Mizu-Trace-ID: 26a930ce5f2a0f09
X-Migadu-Flow: FLOW_OUT
Message-ID: <46079ae8-8b8f-41b5-8cf6-0fe1664b0848@linux.dev>
Date: Mon, 31 Aug 2026 10:41:55 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info
 bounds
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 kys@microsoft.com, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
 <20260710022854.3739558-3-michael.bommarito@gmail.com>
Content-Language: en-US, en-ZM
From: "Nico Pache (Red Hat)" <nico.pache@linux.dev>
In-Reply-To: <20260710022854.3739558-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 8:28 PM, Michael Bommarito wrote:
> Add KUnit coverage for Hyper-V synthetic HID initial device-info parsing.
> The tests cover zero bLength, a valid descriptor plus report descriptor,
> and a malformed report descriptor length that exceeds the received
> message.
> 
> The same-translation-unit test uses a KUnit-only ACK bypass so parser
> coverage does not require a live VMBus channel.
> 
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---

Hi this is breaking builds when compiling the kunit framework as modules.

See below.

>  drivers/hid/Kconfig      |  10 ++++
>  drivers/hid/hid-hyperv.c | 117 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c1d9f7c6a5f23..41ca48d9adc9e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1183,6 +1183,16 @@ config HID_HYPERV_MOUSE
>  	help
>  	Select this option to enable the Hyper-V mouse driver.
>  
> +config HID_HYPERV_MOUSE_KUNIT_TEST
> +	bool "KUnit tests for Hyper-V mouse driver" if !KUNIT_ALL_TESTS

This should either be tristate (instead of bool) or...

> +	depends on KUNIT && HID_HYPERV_MOUSE

... this should be 'KUNIT=y'

Im not familar with this test so I cant judge what is right. Can this test run
as a module or does it have to be builtin?

Cheers,
-- Nico


> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds unit tests for the Hyper-V synthetic HID driver.
> +	  These tests exercise the initial device-info parser with
> +	  malformed host-provided HID descriptors and are only useful
> +	  for kernel developers running KUnit.
> +
>  config HID_SMARTJOYPLUS
>  	tristate "SmartJoy PLUS PS2/USB adapter support"
>  	help
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index fd90196430e29..6579bd19da13a 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -13,6 +13,9 @@
>  #include <linux/hiddev.h>
>  #include <linux/hyperv.h>
>  
> +#if IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST)
> +#include <kunit/test.h>
> +#endif
>  
>  struct hv_input_dev_info {
>  	unsigned int size;
> @@ -240,13 +243,18 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
>  	ack.ack.header.size = 1;
>  	ack.ack.reserved = 0;
>  
> -	ret = vmbus_sendpacket(input_device->device->channel,
> -			&ack,
> -			sizeof(struct pipe_prt_msg) +
> -			sizeof(struct synthhid_device_info_ack),
> -			(unsigned long)&ack,
> -			VM_PKT_DATA_INBAND,
> -			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST) &&
> +	    !input_device->device) {
> +		ret = 0;
> +	} else {
> +		ret = vmbus_sendpacket(input_device->device->channel,
> +				       &ack,
> +				       sizeof(struct pipe_prt_msg) +
> +				       sizeof(struct synthhid_device_info_ack),
> +				       (unsigned long)&ack,
> +				       VM_PKT_DATA_INBAND,
> +				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	}
>  
>  	if (!ret)
>  		input_device->dev_info_status = 0;
> @@ -635,5 +643,100 @@ static void __exit mousevsc_exit(void)
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
>  
> +#if IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST)
> +static struct mousevsc_dev *mousevsc_kunit_alloc_dev(struct kunit *test)
> +{
> +	struct mousevsc_dev *input_dev;
> +
> +	input_dev = kunit_kzalloc(test, sizeof(*input_dev), GFP_KERNEL);
> +	if (!input_dev)
> +		return NULL;
> +
> +	init_completion(&input_dev->wait_event);
> +
> +	return input_dev;
> +}
> +
> +static void mousevsc_device_info_zero_blength(struct kunit *test)
> +{
> +	struct synthhid_device_info *info;
> +	struct mousevsc_dev *input_dev;
> +
> +	input_dev = mousevsc_kunit_alloc_dev(test);
> +	KUNIT_ASSERT_NOT_NULL(test, input_dev);
> +	info = kunit_kzalloc(test, sizeof(*info), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, info);
> +
> +	info->hid_descriptor.bLength = 0;
> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info));
> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -ENOMEM);
> +}
> +
> +static void mousevsc_device_info_valid_descriptor(struct kunit *test)
> +{
> +	struct synthhid_device_info *info;
> +	struct mousevsc_dev *input_dev;
> +	u8 *report;
> +
> +	input_dev = mousevsc_kunit_alloc_dev(test);
> +	KUNIT_ASSERT_NOT_NULL(test, input_dev);
> +	info = kunit_kzalloc(test, sizeof(*info) + 4, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, info);
> +
> +	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
> +	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(4);
> +	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	memset(report, 0x42, 4);
> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 4);
> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, 0);
> +	KUNIT_EXPECT_EQ(test, input_dev->report_desc_size, 4);
> +	KUNIT_EXPECT_MEMEQ(test, input_dev->report_desc, report, 4);
> +
> +	kfree(input_dev->hid_desc);
> +	kfree(input_dev->report_desc);
> +}
> +
> +static void mousevsc_device_info_report_desc_oob(struct kunit *test)
> +{
> +	struct synthhid_device_info *info;
> +	struct mousevsc_dev *input_dev;
> +	u8 *report;
> +
> +	input_dev = mousevsc_kunit_alloc_dev(test);
> +	KUNIT_ASSERT_NOT_NULL(test, input_dev);
> +	info = kunit_kzalloc(test, sizeof(*info) + 8, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, info);
> +
> +	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
> +	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(64);
> +	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	memset(report, 0x42, 8);
> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 8);
> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -EINVAL);
> +
> +	kfree(input_dev->hid_desc);
> +}
> +
> +static struct kunit_case mousevsc_test_cases[] = {
> +	KUNIT_CASE(mousevsc_device_info_zero_blength),
> +	KUNIT_CASE(mousevsc_device_info_valid_descriptor),
> +	KUNIT_CASE(mousevsc_device_info_report_desc_oob),
> +	{}
> +};
> +
> +static struct kunit_suite mousevsc_test_suite = {
> +	.name = "hid_hyperv_mouse",
> +	.test_cases = mousevsc_test_cases,
> +};
> +
> +kunit_test_suite(mousevsc_test_suite);
> +#endif
> +
>  module_init(mousevsc_init);
>  module_exit(mousevsc_exit);

