From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] input: rmi4: Fix redefinition error on compilation.
Date: Thu, 6 Jul 2017 15:14:16 +0530
Message-ID: <8148de7b-d391-3d37-efbb-6823b63ca427@gmail.com>
References: <da1fe5ae1774e12965e6c6748f21b6a6b6e2e5c1.1499329112.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <da1fe5ae1774e12965e6c6748f21b6a6b6e2e5c1.1499329112.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Sorry for noise. Please ignore this patch

Thanks
~arvind

On Thursday 06 July 2017 02:35 PM, Arvind Yadav wrote:
> If CONFIG_RMI4_F34 is disable, it'll through compilation error.
>
> drivers/input/rmi4/rmi_f34.c:594:5: error: redefinition of ‘rmi_f34_create_sysfs’
>   int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
>       ^
> In file included from drivers/input/rmi4/rmi_f34.c:17:0:
> drivers/input/rmi4/rmi_driver.h:127:19: note: previous definition of ‘rmi_f34_create_sysfs’ was here
>   static inline int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
>                     ^
> drivers/input/rmi4/rmi_f34.c:599:6: error: redefinition of ‘rmi_f34_remove_sysfs’
>   void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
>        ^
> In file included from drivers/input/rmi4/rmi_f34.c:17:0:
> drivers/input/rmi4/rmi_driver.h:132:20: note: previous definition of ‘rmi_f34_remove_sysfs’ was here
>   static inline void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/input/rmi4/rmi_f34.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 4cfe970..0f9b905 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -590,7 +590,7 @@ static int rmi_f34_probe(struct rmi_function *fn)
>   
>   	return 0;
>   }
> -
> +#ifdef CONFIG_RMI4_F34
>   int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
>   {
>   	return sysfs_create_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
> @@ -600,7 +600,7 @@ void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
>   {
>   	sysfs_remove_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
>   }
> -
> +#endif
>   struct rmi_function_handler rmi_f34_handler = {
>   	.driver = {
>   		.name = "rmi4_f34",
