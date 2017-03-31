From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/4] Input: synaptics-rmi4 - fix endianness issue in
 SMBus transport
Date: Fri, 31 Mar 2017 11:15:05 +0200
Message-ID: <20170331091505.GH22683@mail.corp.redhat.com>
References: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
 <20170325060050.39867-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170325060050.39867-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

On Mar 24 2017 or thereabouts, Dmitry Torokhov wrote:
> The mapping table holds address in LE form, so we should convert it
> to CPU when comparing it.

Are you sure about that?

>From what I can read:
rmiaddr is set by rmi_smb_get_command_code(), and it's forwarded
directly from the caller to the table. When we write the data to the
device, we use cpu_to_le16() so rmiaddr is used as le16, but always
stored as CPU type.

> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/rmi4/rmi_smbus.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index 76752555d809..c8bf49686460 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -89,17 +89,16 @@ static int rmi_smb_get_command_code(struct rmi_transport_dev *xport,
>  
>  	mutex_lock(&rmi_smb->mappingtable_mutex);
>  	for (i = 0; i < RMI_SMB2_MAP_SIZE; i++) {
> -		if (rmi_smb->mapping_table[i].rmiaddr == rmiaddr) {
> +		struct mapping_table_entry *entry = &rmi_smb->mapping_table[i];

In case you want to keep the temporary variable here, I believe
checkpatch would complain about a missing empty line here (just
nitpicking).

Cheers,
Benjamin

> +		if (le16_to_cpu(entry->rmiaddr) == rmiaddr) {
>  			if (isread) {
> -				if (rmi_smb->mapping_table[i].readcount
> -							== bytecount) {
> +				if (entry->readcount == bytecount) {
>  					*commandcode = i;
>  					retval = 0;
>  					goto exit;
>  				}
>  			} else {
> -				if (rmi_smb->mapping_table[i].flags &
> -							RMI_SMB2_MAP_FLAGS_WE) {
> +				if (entry->flags & RMI_SMB2_MAP_FLAGS_WE) {
>  					*commandcode = i;
>  					retval = 0;
>  					goto exit;
> -- 
> 2.12.1.578.ge9c3154ca4-goog
> 
