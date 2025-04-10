load_model='RWKV-x070-World-0.1B-v2.8-20241210-ctx4096.pth'
proj_dir='output'
data_file="$data_path/data"

n_layer=12
n_embd=768

micro_bsz=1
epoch_save=1
epoch_steps=1000
ctx_len=512

lora_config='{"lora_load":"","lora_r":32,"lora_alpha":64,"lora_dropout":0.01}'


python train.py --load_model $load_model \
--proj_dir $proj_dir --data_file $data_file \
--vocab_size 65536 \
--n_layer $n_layer --n_embd $n_embd \
--data_type binidx --dataload pad --loss_mask pad \
--ctx_len $ctx_len --micro_bsz $micro_bsz \
--epoch_steps $epoch_steps --epoch_count 20 --epoch_begin 0 --epoch_save $epoch_save \
--lr_init 2e-5 --lr_final 2e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 1 --precision fp16 --strategy deepspeed_stage_1 --grad_cp 0 \
--my_testing "x070" \
--peft lora --lora_config $lora_config
